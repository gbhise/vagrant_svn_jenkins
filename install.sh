#!/bin/bash
svn_vhost_file=/etc/apache2/sites-available/testrepo.conf
# This function is called at the very bottom of the file
main() {
	updateandinstall
	createfolder
	configsetting
	enableappache
	addsvnuser
	installjenkins
}


updateandinstall() {
sudo apt-get -y update
sudo apt-get -y install subversion apache2 libapache2-svn apache2-utils 

}

createfolder() {
sudo mkdir -p /svn/repos/
sudo svnadmin create /svn/repos/testrepo
sudo chown -R www-data:www-data /svn/repos/testrepo
sudo touch /etc/apache2/sites-available/testrepo.conf
}

configsetting() {

cat << EOF > /etc/apache2/sites-available/testrepo.conf
<Location /svn>
  DAV svn
  SVNParentPath /svn/repos/
  AuthType Basic
  AuthName "Test Repo"
  AuthUserFile /etc/svnpasswd
  Require valid-user
 </Location>
EOF


}

enableappache() {
sudo a2enmod authz_svn
sudo a2ensite testrepo
sudo service apache2 restart
}

addsvnuser() {
sudo htpasswd -cmb /etc/svnpasswd admin admin
}

installjenkins() {
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get -y install openjdk-7-jdk
sudo apt-get -y install jenkins
sudo apt-get -y install ant
sudo service jenkins status
sudo su - jenkins
ssh-keygen -t rsa -N "" -f "$PWD"/.ssh/id_rsa
}

main
exit 0