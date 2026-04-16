import os
import subprocess
from pathlib import Path
from urllib.parse import urlparse
from collections import defaultdict
from rich.console import Console
from rich.table import Table
from rich.text import Text
from rich.status import Status


def run_command(cmd, cwd):
    """執行指令並傳回結果，失敗時傳回 None"""
    try:
        result = subprocess.run(
            cmd, cwd=cwd, capture_output=True, text=True, check=True
        )
        return result.stdout.strip()
    except Exception:
        return None

def get_git_info(path):
    """取得特定路徑的 Git 資訊"""
    if not (path / ".git").exists():
        return {
            "is_git": False,
            "remote": "[grey50]N/A[/]",
            "sync": "[grey50]N/A[/]",
            "workspace": "[grey50]無 Git 倉庫[/]",
            "clean_target": "[grey50]N/A[/]"
        }

    # 1. 遠端 Domain 與 同步狀態
    remote_url = run_command(["git", "remote", "get-url", "origin"], path)
    remote_domain = "[yellow]沒有遠端[/]"
    sync_status = "[grey50]-[/]"
    
    if remote_url:
        if "://" in remote_url:
            remote_domain = urlparse(remote_url).netloc
        else: # SSH 格式
            remote_domain = remote_url.split("@")[-1].split(":")[0]
        
        # 檢查與上游的差異 (HEAD vs @{u})
        diff = run_command(["git", "rev-list", "--left-right", "--count", "HEAD...@{u}"], path)
        if diff:
            ahead, behind = map(int, diff.split())
            if ahead == 0 and behind == 0:
                sync_status = "[green]同步[/]"
            elif ahead > 0 and behind == 0:
                sync_status = f"[cyan]超過遠端 (+{ahead})[/]"
            elif ahead == 0 and behind > 0:
                sync_status = f"[red]落後遠端 (-{behind})[/]"
            else:
                sync_status = "[bold yellow]混合狀態 (±)[/]"
        else:
            sync_status = "[dim]未追蹤遠端[/]"

    # 2. 工作區狀態 (Workspace Cleanliness)
    status_short = run_command(["git", "status", "--short"], path)
    if not status_short:
        workspace = "[green]✔ Clean[/]"
    else:
        workspace = "[bold red]✘ 有變更/未追蹤[/]"

    # 3. 檢查是否有忽略的檔案 (通常是編譯產物 target)
    ignored_files = run_command(["git", "clean", "-Xn"], path)
    clean_target = "[yellow]⚠ 有 target[/]" if ignored_files else "[green]✔ 沒 target[/]"

    return {
        "is_git": True,
        "remote": remote_domain,
        "sync": sync_status,
        "workspace": workspace,
        "clean_target": clean_target
    }

def main():
    # 初始化 Rich 控制台
    console = Console()
    root = Path(".")
    # 使用 dict 來進行分組: { group_name: [(display_name, full_path), ...] }
    groups = defaultdict(list)

    with Status("[bold blue]正在掃描目錄結構...", console=console):
        # 層級遍歷邏輯
        for first_level in sorted(root.iterdir()):
            if not first_level.is_dir() or first_level.name.startswith("."):
                continue
            
            for second_level in sorted(first_level.iterdir()):
                if not second_level.is_dir():
                    continue
                
                # 如果資料夾名結尾為 .workspace，進入層級三
                if second_level.name.endswith(".workspace"):
                    group_name = second_level.name
                    for third_level in sorted(second_level.iterdir()):
                        if third_level.is_dir():
                            groups[group_name].append((third_level.name, third_level))
                else:
                    group_name = first_level.name
                    groups[group_name].append((second_level.name, second_level))

    # 建立表格
    table = Table(
        title="[bold underline]開發環境 Git 狀態總覽[/]", 
        title_style="cyan", 
        show_header=True, 
        header_style="bold magenta",
        box=None,
        pad_edge=False
    )
    
    table.add_column("專案名稱", style="bold white", width=30)
    table.add_column("工作區狀態", justify="left", width=25)
    table.add_column("遠端域名", justify="left")
    table.add_column("同步狀態", justify="center")
    table.add_column("忽略檔案 (Target)", justify="left")

    # 填充表格
    with Status("[bold green]正在檢查 Git 狀態...", console=console):
        for group in sorted(groups.keys()):
            # 加入分組標頭列
            table.add_row(f"[bold blue]📂 {group}[/]", "", "", "", "")
            
            for display_name, full_path in groups[group]:
                info = get_git_info(full_path)
                table.add_row(
                    f"  [dim]└─[/] {display_name}",
                    info["workspace"],
                    info["remote"],
                    info["sync"],
                    info["clean_target"]
                )
            # 在組別間加入空行提高可讀性
            table.add_row("", "", "", "", "")

    console.print(table)

if __name__ == "__main__":
    main()
