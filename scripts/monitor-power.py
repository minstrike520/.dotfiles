#!/usr/bin/python3
import os
import time
import curses
import time
import argparse

# Intel RAPL 路徑 (通常 package-0 是整個 CPU 插槽)
RAPL_PATH = "/sys/class/powercap/intel-rapl/intel-rapl:0"
ENERGY_FILE = os.path.join(RAPL_PATH, "energy_uj")
NAME_FILE = os.path.join(RAPL_PATH, "name")

def get_energy():
    """讀取當前能量數值 (microjoules)"""
    try:
        with open(ENERGY_FILE, "r") as f:
            return int(f.read().strip())
    except FileNotFoundError:
        return None

def get_device_name():
    """讀取設備名稱"""
    try:
        with open(NAME_FILE, "r") as f:
            return f.read().strip()
    except:
        return "Unknown Intel RAPL Device"

def _full_screen(stdscr):
    # 設置 curses
    curses.curs_set(0)  # 隱藏游標
    stdscr.nodelay(True) # 非阻塞模式
    stdscr.timeout(1000) # 更新頻率 (ms)

    device_name = get_device_name()
    last_energy = get_energy()
    last_time = time.time()
    
    if last_energy is None:
        stdscr.addstr(0, 0, "錯誤: 找不到 Intel RAPL 接口。請確保載入了 intel_rapl 模組並具備讀取權限。")
        stdscr.refresh()
        time.sleep(3)
        return

    start_energy = last_energy
    total_energy_wh = 0.0

    while True:
        stdscr.erase()
        current_time = time.time()
        current_energy = get_energy()
        
        if current_energy is None:
            break

        # 計算差值
        delta_energy_uj = current_energy - last_energy
        delta_time = current_time - last_time
        
        # 處理計數器重置 (RAPL counter overflow)
        if delta_energy_uj < 0:
            delta_energy_uj = 0
            
        # 計算即時瓦數 (W = J/s)
        current_watts = (delta_energy_uj / 1_000_000) / delta_time
        
        # 計算累計用電 (Wh)
        # 1 Wh = 3600 J = 3,600,000,000 uJ
        total_consumed_uj = current_energy - start_energy
        if total_consumed_uj < 0: # 處理溢位重置起點
            start_energy = current_energy
            total_consumed_uj = 0
        total_energy_wh = (total_consumed_uj / 3_600_000_000)

        # 顯示介面
        stdscr.attron(curses.A_BOLD | curses.color_pair(1))
        stdscr.addstr(0, 0, f"--- Intel RAPL 功率監控器 ---")
        stdscr.attroff(curses.A_BOLD)
        
        stdscr.addstr(2, 2, f"設備名稱: {device_name}")
        stdscr.addstr(4, 2, f"即時功率: ", curses.A_BOLD)
        stdscr.addstr(4, 12, f"{current_watts:>8.2f} Watts", curses.color_pair(2))
        
        stdscr.addstr(5, 2, f"累計能量: ", curses.A_BOLD)
        stdscr.addstr(5, 12, f"{total_energy_wh:>8.6f} Wh")
        
        stdscr.addstr(7, 2, "按 'q' 退出程式")

        # 更新歷史數據
        last_energy = current_energy
        last_time = current_time

        stdscr.refresh()

        # 檢測退出鍵
        key = stdscr.getch()
        if key == ord('q'):
            break

def start_curses(stdscr):
    curses.start_color()
    curses.init_pair(1, curses.COLOR_CYAN, curses.COLOR_BLACK)
    curses.init_pair(2, curses.COLOR_GREEN, curses.COLOR_BLACK)
    _full_screen(stdscr)

def full_screen():
    # 初始化顏色
    curses.wrapper(start_curses)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument("mode", help="tui | formatted")

    args = parser.parse_args()

    if args.mode == "tui":
        full_screen()
    elif args.mode == "formatted":
        a = get_energy()

        time.sleep(0.7)

        b = get_energy()

        delta = (b - a) / 0.7 / 1_000_000
        
        print("{:02.0f}\nWt.".format(delta))
    else:
        print("Error: '{}' is not a valid option.".format(args.mode))
