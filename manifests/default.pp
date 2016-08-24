exec { 'time date':
	command => '/usr/bin/timedatectl set-timezone Europe/Paris'
}

exec { 'apt-get update':
	command => '/usr/bin/apt-get update -yq',
	require => Exec [ 'time date' ]	
}

# GIT

exec { 'add git repository':
	command => '/usr/bin/apt-add-repository ppa:git-core/ppa -y'
}

exec { 'apt-get update git':
	command => '/usr/bin/apt-get update -yq',
	require => Exec [ 'add git repository' ]	
}

exec { 'install git':
	command => '/usr/bin/apt-get install git -yq',
	require => Exec [ 'apt-get update git' ]
}

package { 'git':
  ensure  => 'present',
  require => Exec [ 'install git' ]
}


# Nginx
exec { 'install nginx':
	command => '/usr/bin/apt-get install nginx -yq',
	require => Exec [ 'apt-get update' ]	
}

# NODE JS

exec { 'download nodejs':
	command => '/usr/bin/curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -',
	require => Exec [ 'apt-get update' ]	
}

exec { 'install nodejs':
	command => '/usr/bin/apt-get install -y nodejs',
	require => Exec [ 'download nodejs' ]	
}

package { 'nodejs':
  ensure  => 'present',
  require => Exec [ 'install nodejs' ]
}


# JQ

exec { 'install jq':
	command => '/usr/bin/apt-get install -yq jq',
	require => Exec [ 'apt-get update' ]
}

package { 'jq':
  ensure  => 'present',
  require => Exec [ 'install jq' ]
}


# JAVA tools

exec { 'add java repository':
	command => '/usr/bin/apt-add-repository ppa:openjdk-r/ppa -y'
}

exec { 'apt-get update java':
	command => '/usr/bin/apt-get update -yq',
	require => Exec [ 'add java repository' ]
}

exec { 'install java':
	command => '/usr/bin/apt-get install openjdk-8-jdk -y',
	require => Exec [ 'apt-get update java' ]
}

exec { 'add JAVA_HOME':
	command => '/bin/echo \'JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64\' >> /home/vagrant/.bashrc && /bin/echo \'export JAVA_HOME\' >> /home/vagrant/.bashrc',
	require => Exec [ 'install java' ]
}

# Maven

exec { 'add maven repository':
	command => '/usr/bin/apt-add-repository ppa:andrei-pozolotin/maven3 -y',
}

exec { 'apt-get update maven':
	command => '/usr/bin/apt-get update -yq',
	require => Exec [ 'add maven repository' ]
}

package { 'maven':
  ensure  => 'present',
  require => Exec [ 'apt-get update maven' ],
}


# Docker

exec { 'install docker':
	command => '/usr/bin/apt-get install docker.io -y',
	require => Exec [ 'apt-get update' ]
}

package { 'docker':
  ensure  => 'present',
  require => Exec [ 'install docker' ]
}


# Node Modules

exec { '(Node modules) install grunt':
	command => '/usr/bin/npm install -g grunt-cli',
	require => Package [ 'nodejs' ]
}

exec { '(Node modules) install gulp':
	command => '/usr/bin/npm install -g gulp',
	require => Package [ 'nodejs' ]
}


exec { '(Node modules) install bower':
	command => '/usr/bin/npm install -g bower',
	require => Package [ 'nodejs' ]
}


exec { '(Node modules) install yoman':
	command => '/usr/bin/npm install -g yo',
	require => Package [ 'nodejs' ]
}


exec { '(Node modules) install generator angular':
	command => '/usr/bin/npm install -g generator-angular',
	require => Exec [ '(Node modules) install yoman' ]
}

exec { '(Node modules) install generator karma':
	command => '/usr/bin/npm install -g generator-karma',
	require => Exec [ '(Node modules) install yoman' ]
}

exec { '(Node modules) install api mocker':
	command => '/usr/bin/npm install -g apimocker',
	require => Package [ 'nodejs' ]
}


exec { '(Node modules) install phantomjs':
	command => '/usr/bin/npm install -g phantomjs',
	require => Package [ 'nodejs' ]
}

exec { 'add PHANTOMJS_BIN':
	command => '/bin/echo \'PHANTOMJS_BIN=/usr/bin/phantomjs\' >> /home/vagrant/.bashrc && /bin/echo \'export PHANTOMJS_BIN\' >> /home/vagrant/.bashrc',
	require => Exec [ '(Node modules) install phantomjs' ]
}


# Ruby

exec { 'install ruby dev':
	command => '/usr/bin/apt-get install ruby-dev -yq',
	require => Exec [ 'apt-get update' ]
}

exec { '(Gem modules) install bundler':
	command => '/usr/bin/gem install bundler',
	require => Exec [ 'install ruby dev' ]
}

exec { '(Gem modules) install compass':
	command => '/usr/bin/gem install compass',
	require => Exec [ 'install ruby dev' ]
}

