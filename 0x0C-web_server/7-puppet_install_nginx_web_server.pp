# install nginx  (w/ Puppet)
exec { 'updating packages':
    command => 'apt-get -y update',
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

package { 'nginx':
    ensure => 'installed',
}

exec { 'allow HTTP':
  command => "ufw allow 'Nginx HTTP'",
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  onlyif  => '! dpkg -l nginx | egrep \'îi.*nginx\' > /dev/null 2>&1',
}

exec { 'chmod www folder':
  command => 'chmod -R 755 /var/www',
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',

}


file { '/var/www/html/index.html':
    content => 'Hello World!\n',
}

file { 'Nginx default file':
    ensure => file,
    path => '/etc/nginx/sites-enabled/default',
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

exec { 'restart service':
  command => 'service nginx restart',
  path    => '/usr/bin:/usr/sbin:/bin',
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}