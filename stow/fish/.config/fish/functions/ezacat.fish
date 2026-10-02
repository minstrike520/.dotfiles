function ezacat
  echo -e "\033[1;34m=== Directories ===\033[0m"
  eza -lD --icons always

  echo -e "\n\033[1;35m=== Images ===\033[0m"
  eza -lf --icons always *.png *.jpg *.jpeg *.gif *.webp 2>/dev/null

  echo -e "\n\033[1;36m=== Videos ===\033[0m"
  eza -lf --icons always *.mp4 *.mkv *.avi *.mov 2>/dev/null

  echo -e "\n\033[1;33m=== Documents ===\033[0m"
  eza -lf --icons always *.pdf *.txt *.md *.docx 2>/dev/null

  echo -e "\n\033[1;37m=== Others ===\033[0m"
  eza -lf --icons always -I "*.png|*.jpg|*.jpeg|*.gif|*.webp|*.mp4|*.mkv|*.avi|*.mov|*.pdf|*.txt|*.md|*.docx"
end
