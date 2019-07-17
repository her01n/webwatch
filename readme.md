This is a script to periodically check the availability of a web page and
send a mail to admin in case of problems.

# Requirements

Install ruby, msmtp and curl packages.

# URLs

The list of web pages to test is specified in file /etc/webwatch/urllist.
The file contains a list of full urls, each on a separate line. Lines starting with '#' are ignored.
'http', 'https' and 'ftp' urls are supported. For example:

```
# This is a comment
http://web-page.com/
https://www.web-page.com/
```

Test would follow redirections, including across the protocols, so you can add 'http' url to test
if it would correctly redirect to 'https'.

# Mail

Mail configuration is read from file /etc/webwatch/msmtp.cfg.
The format of the file is described in msmtp manual. An example for mail.com service:

```
auth on
tls on
host smtp.mail.com
port 587
user username@domain.com
password <password>
from username@domain.com
```

The file needs to be unreadable by other users. Fix it with:

   # chmod go-rw /etc/webwatch/msmtp.cfg

You can test the mail with command:

   # echo hello | msmtp -C ~/.config/webwatch/msmtp.cfg yourmail@mail.com

Write the mail address of the recipient in file /etc/webwatch/admin.

# Installation

Install the script by executing 'make install' in the project directory.
This would also enable the systemd timer to execute the script periodically. 
You can check the status of last test run in /var/lib/webwatch/status.
