import os
import sys

def count_and_sort_subdirs():
    pwd = os.getcwd()
    results = []
    
    # 取得第一層目錄清單
    subdirs = [d for d in os.listdir(pwd) if os.path.isdir(os.path.join(pwd, d))]
    
    for folder in subdirs:
        # 在 stderr 輸出目前正在處理的資料夾（\r 回到行首，end='' 不換行）
        sys.stderr.write(f"\r正在處理: {folder[:30]}...")
        sys.stderr.flush()
        
        folder_path = os.path.join(pwd, folder)
        total_count = 0
        
        for root, dirs, files in os.walk(folder_path):
            total_count += len(dirs) + len(files)
        
        results.append((folder, total_count))
    
    # 清除 stderr 的最後一行提示訊息
    sys.stderr.write("\r" + " " * 50 + "\r")
    sys.stderr.flush()

    # 依照數量排序 (由大到小)，若要按名稱排可改為 key=lambda x: x[0]
    results.sort(key=lambda x: x[1], reverse=True)

    # 最後正式列印結果
    print(f"{'資料夾名稱':<30} | {'項目總數':<10}")
    print("-" * 45)
    for name, count in results:
        print(f"{name:<30} | {count:<10}")

if __name__ == "__main__":
    count_and_sort_subdirs()
