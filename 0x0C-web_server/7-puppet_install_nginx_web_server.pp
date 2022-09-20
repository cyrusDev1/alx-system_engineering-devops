# install nginx  (w/ Puppet)
package { 'nginx':
    ensure => installed,
}

file_line { 'Nginx default file':
    ensure => 'present',
    path   => '/etc/nginx/sites-available/default',
    after  => 'server_name _;',
    line   => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
}

file { '/var/www/html/index.html':
    content => 'Hello World!',
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
