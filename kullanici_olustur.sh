#!/bin/bash
#lb42project

DATA=$(zenity --forms --title="Kullanıcı oluştur" \
              --text="" \
              --add-password="Çalışan hesaptaki şifreyi girin : ")


currp=$(awk -F'|' '{print $1}' <<< "$DATA")

if echo "$currp" | sudo -S echo "" >/dev/null 2>&1; then
    
    DATA=$(zenity --forms --title="Kullanıcı oluştur" \
                  --text="" \
                  --add-entry="Yeni kullanıcı adı : " \
                  --add-password="Yeni kullanıcı şifresi : " \
                  --add-password="Yeni kullanıcı şifresini tekrar girin : ")

  
    un=$(awk -F'|' '{print $1}' <<< "$DATA")
    np=$(awk -F'|' '{print $2}' <<< "$DATA")
    conp=$(awk -F'|' '{print $3}' <<< "$DATA")

   
    if [ "$np" = "$conp" ]; then
       
        sudo useradd -m "$un"

       
        echo -e "$np\n$np" | sudo passwd "$un"

        zenity --info --title="Kullanıcı oluştur" --text="İşlem Başarılı"
    else
        zenity --error --title="Kullanıcı oluştur" --text="Şifreler Eşleşmiyor"
    fi
else
    zenity --error --title="Kullanıcı oluştur" --text="Şifre Doğrulanamadı"
fi
