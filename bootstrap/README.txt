# Place dotfiles files in user deploy's home folder and dot-rename them.

# From http://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers

# For root, iff root exists
passw

apt-get update
apt-get upgrade

apt-get install fail2ban

useradd deploy
mkdir /home/deploy
mkdir /home/deploy/.ssh
chmod 700 /home/deploy/.ssh

chmod 400 /home/deploy/.ssh/authorized_keys
chown deploy:deploy /home/deploy -R

# For deploy
passwd deploy

# Add deploy to visudoers
usermod -a -G sudo deploy


# Ansible overwrite /etc/ssh/sshd_config via ansible

# Restart ssh
service ssh restart

# Configure ufw
ufw allow from 46.65.43.42 to any port 10981
ufw allow 80
ufw allow 443
ufw enable

# Ansible overwrite /etc/apt/apt.conf.d/10periodic

# Ansible overwrite /etc/cron.daily/00logwatch



# Install logwatch and enable cron
apt-get install logwatch

nano

