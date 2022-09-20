# Time to practice configuring your server with Puppet! Just as you
# did before, we’d like you to install and configure an Nginx server
# using Puppet instead of Bash. To save time and effort, you should
# also include resources in your orm a 301 redirect when querying /redirect_me.

exec { 'updating packages':
    command => 'apt-get -y update',
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

package { 'nginx':
    ensure => 'installed',
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
