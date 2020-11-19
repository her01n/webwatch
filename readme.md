This is a script to periodically check the availability of a web page and
send a mail to admin in case of problems.

## Requirements

Install curl, make, msmtp and ruby packages.

## Configuration

Create a configuration file in /etc/webwatch.config.
Lines starting with '#' and empty lines are ignored.
At least one url must be specified.

List of configuration options:

- **url = http://host/path**

  Specify an url to test.
  May be specified more than once, supported protocols are 'http', 'https' and 'ftp'.
  Test would follow redirections, including across the protocols, so you can add 'http' url to test
  if it would correctly redirect to 'https'.

- **admin = admin@example.com**

  Mail address that would be sent an e-mail in case of a test failure.

- **smtp-host = smtp.gmail.com**

  Host of SMTP server.

- **smtp-user = your.name@gmail.com**

  SMTP Username.

- **smtp-password = pass**

  SMTP Password. Password should be written as is (not in quotes).

You can test email configuration with command:

    $ ./webwatch --test-mail

The password is kept in plain text, it is advisable to set access to owner only.

    # chown root:root /etc/webwatch.config
    # chmod go-rwx /etc/webwatch.config

# Installation

Install the script by executing 'make install' in the project directory.
This would also enable the systemd timer to execute the script periodically. 
You can check the status of last test run in /var/lib/webwatch/status.

To manualy trigger the check, run

    $ systemctl start webwatch

