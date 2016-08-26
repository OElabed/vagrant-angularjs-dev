# Vagrant Angular JS dev environnement 


Provide a vagrant box to install dev dependencies for angular dependencies.

### Installation
You need to install Vagrant and virtualBox.
```sh
$ git clone [git-repo-url] ang-env
$ cd ang-env
$ vagrant up --provision
$ vagrant ssh
```


### Override npm install Symbolic Links error

You need to create a symbolic link with the /home/vagrant/node_modules into your project root folder.

```sh
$ ln -s /home/vagrant/node_modules/ node_module
```


License
----

MIT


**Free Software, Hell Yeah!**

   [git-repo-url]: <https://github.com/OElabed/vagrant-angularjs-dev.git>
  
