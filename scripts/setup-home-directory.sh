mkdir -p ~/app
mkdir -p ~/dev/{projects,playground,third-party}
mkdir -p ~/docs
mkdir -p ~/downloads
mkdir -p ~/pics/screnshots
mkdir -p ~/tmp
mkdir -p ~/vids/records

# DESKTOP, DOWNLOAD, TEMPLATES, PUBLICSHARE, DOCUMENTS, MUSIC, PICTURES, VIDEOS

xdg-user-dirs-update --set DESKTOP ~
xdg-user-dirs-update --set DOWNLOAD ~/downloads
# xdg-user-dirs-update --set TEMPLATES ~
# xdg-user-dirs-update --set PUBLICSHARE ~
xdg-user-dirs-update --set DOCUMENTS ~/docs
# xdg-user-dirs-update --set MUSIC ~
xdg-user-dirs-update --set PICTURES ~/pics
xdg-user-dirs-update --set VIDEOS ~/vids

rm -r 下載 公共 圖片 影片 文件 桌面 模本 音樂
