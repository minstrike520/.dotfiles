#!/usr/bin/env python3
import argparse
import sys
import re

def process_file(input_path, output_path, override_freq):
    try:
        with open(input_path, 'r', encoding='utf-8') as f_in, \
             open(output_path, 'w', encoding='utf-8') as f_out:
            
            count = 0
            for line in f_in:
                line_content = line.strip()
                
                # 1. 跳過空行或 # 開頭的註解
                if not line_content or line_content.startswith('#'):
                    # 註解行直接原樣保留或跳過，這裡選擇直接保留註解以維持檔案結構
                    if line_content.startswith('#'):
                        f_out.write(line)
                    continue
                
                # 分割欄位 (預設：詞 頻率 注音)
                parts = line_content.split()
                if not parts:
                    continue
                
                word = parts[0]
                
                if len(word) > 1:
                    # 複字詞：直接原樣寫入
                    f_out.write(line)
                    count += 1
                else:
                    # 單字詞：根據 flag 決定行為
                    if override_freq:
                        # 將頻率（第二欄）改為 1
                        # 我們重建這一行，保留詞、新頻率(1)、以及後續所有的注音
                        new_parts = [parts[0], "1"] + parts[2:]
                        f_out.write(" ".join(new_parts) + "\n")
                        count += 1
                    else:
                        # 未開啟 -o，則刪除單字詞（即不寫入檔案）
                        continue
            
            mode_str = "修改詞頻為 1" if override_freq else "刪除"
            print(f"處理完成！對單字詞執行了 [{mode_str}] 動作。")
            print(f"結果已儲存至: {output_path}")

    except FileNotFoundError:
        print(f"錯誤：找不到檔案 '{input_path}'", file=sys.stderr)
    except Exception as e:
        print(f"發生預期外的錯誤: {e}", file=sys.stderr)

def main():
    parser = argparse.ArgumentParser(description="詞典過濾工具：處理單字詞與註解。")
    
    # 必要參數：輸入檔案
    parser.add_argument("input", help="輸入的原始檔案路徑")
    
    # 輸出檔案路徑 (改用 --out 避免與 -o 衝突，或固定預設值)
    parser.add_argument("--dest", default="output.txt", help="輸出的檔案路徑 (預設: output.txt)")
    
    # 功能開關：-o (Override frequency)
    parser.add_argument("-o", "--override", action="store_true", 
                        help="觸發此開關時，保留單字詞並將其詞頻調為 1；不觸發則直接刪除單字詞。")

    args = parser.parse_args()

    process_file(args.input, args.dest, args.override)

if __name__ == "__main__":
    main()
