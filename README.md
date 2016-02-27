# LocalDeal
For creating a deal site for future

<b>How to deploy on a  new ec-2 server</b>
Follow this blog post as it is.
https://gorails.com/setup/ubuntu/14.10

1) sudo apt-get update
   sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
2) First you install rbenv, and then ruby-build
   a) git clone git://github.com/sstephenson/rbenv.git .rbenv
      echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
      echo 'eval "$(rbenv init -)"' >> ~/.bashrc
      exec $SHELL
   b) git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
      echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
      exec $SHELL
   c) git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
      rbenv install 2.2.2
      rbenv global 2.2.2
      ruby -v
3) Tell ruby gem not to install doc
      echo "gem: --no-ri --no-rdoc" > ~/.gemrc
      gem install bundler

4) Configure git
    git config --global color.ui true
    git config --global user.name "Piyush Beli"
    git config --global user.email "piyush.beli@gmail.com"
    ssh-keygen -t rsa -C "piyush.beli@gmail.com"   //I have already added this key to git, no need to repeat
    Copy this generated file into git keys
    cat ~/.ssh/id_rsa.pub

5) Install rails
   sudo add-apt-repository ppa:chris-lea/node.js
   sudo apt-get update
   sudo apt-get install nodejs
   rbenv rehash

6) Install libsql
   sudo apt-get install libmysqlclient-dev

7) Install bower and dependencies
sudo npm install bower -g
bower install

8) Install elastic search server, follow the instruction given here
1) Run install_elastic_search.sh -2.1.1
2) then follow https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-elasticsearch-on-ubuntu-14-04 post of setting up elastic server correctly.

Change the cluster name to "paylow" and nodename to "paylow-node-1" in elastissearch.yml file once elastic
search server is installed.

In case you see that server is not starting, try running it from here.
cd /usr/share/elasticsearch/bin
./elasticsearch
It should show erroron console. In case it is something with logging file then create a softlink for config file.
In this folder execute the command sudo ln -s /etc/elasticsearch config

9) Install redis-server
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install tcl8.5
wget http://download.redis.io/releases/redis-stable.tar.gz
tar xzf redis-stable.tar.gz
cd redis-stable
make test
sudo make install
cd utils
sudo ./install_server.sh
sudo service redis_6379 start

You can then access the redis database by typing the following command:
redis-cli

10) Clone the repo from git
git clone git@github.com:piyushbeli/LocalDeal.git
cd LocalDeal
bundle install
rake db:create
rake db:setup

11) To build the elastic search index, run this rake task
rake paylow_custom:warmup_elastic_search_index
rake paylow_custom:warmup_cache


Run Rails server in production mode
You need to precompile the assets beforehand
1) rake assets:precompile
set this in production.rb
2) config.assets.compile = true
3) Set below environmental variables
export ROR_DATABASE_PASSWORD=PB#aug12
export SECRET_KEY_BASE=234687071d976b5607188cce288b01fcfe414543f6d9c7cd2e4a391c4140009e363ea0bf17b747f14107f

rails server -b ec2-52-25-234-99.us-west-2.compute.amazonaws.com -p 3000 -e production

To setup the nginx and passenger follow this post
https://www.digitalocean.com/community/tutorials/how-to-install-rails-and-nginx-with-passenger-on-ubuntu

12) To Run the scheduled job
run this command from project root 'whenever --set environment=development --write-crontab'



