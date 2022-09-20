# install nginx  (w/ Puppet)

package { 'nginx':
    ensure => 'installed',
}

file { '/var/www/html/index.html':
    content => 'Hello World!',
}

file { 'Nginx default file':
    ensure  => file,
    path    => '/etc/nginx/sites-enabled/default',
    content => "server {
        listen 80 default_server;
        listen [::]:80 default_server;
               root /var/www/html;
        index index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files \$uri \$uri/ =404;
        }
        
        location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4
        }
}",
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}