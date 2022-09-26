# install nginx  (w/ Puppet)

exec { 'command':
    command  => 'apt-get -y update;
    apt-get install nginx;
    sed -i "/listen 80 default_server;/a add_header X-Served-By $HOSTNAME;" /etc/nginx/sites-available/default;
    service nginx restart'
    provider => 'Shell'
}
