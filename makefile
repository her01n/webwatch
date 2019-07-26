install:
	install webwatch /usr/local/bin
	install webwatch.service webwatch.timer /usr/lib/systemd/system
	mkdir -p /etc/webwatch
	systemctl daemon-reload
	systemctl enable webwatch.timer
	systemctl start webwatch.timer
