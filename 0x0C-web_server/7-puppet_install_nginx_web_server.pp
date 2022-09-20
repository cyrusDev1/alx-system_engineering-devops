# install nginx  (w/ Puppet)
package { 'nginx':
    ensure => installed,
}

file _line { 'Nginx default file':
    ensure => 'present',
    path   => '/etc/nginx/sites-available/default',
    after  => 'server_name _;',
    line   => "\n\tlocation /redirect_me {\n\treturn 301 https://www.youtube.com/watch?v=QH2-TGUlwu4\n\t}",
}

file { '/var/www/html/index.html':
    content => 'Hello World!',
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
