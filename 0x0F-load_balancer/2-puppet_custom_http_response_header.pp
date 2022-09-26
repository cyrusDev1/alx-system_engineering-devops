# install nginx  (w/ Puppet)
package { 'nginx':
    ensure => installed,
}

file_line { 'Nginx default file':
    ensure => 'present',
    path   => '/etc/nginx/sites-available/default',
    after  => 'server_name _;',
    line   => "\n\tlocation /redirect_me {\n\t\treturn 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;\n\t}\n",
    require => Package['nginx'],
}

file_line { 'headers':
    ensure  => 'present',
    path    => '/etc/nginx/sites-available/default',
    after   => 'listen 80 default_server;',
    line    => 'add_header X-Served-By $hostname;',
    require => Package['nginx'],
}

file { '/var/www/html/index.html':
    content => 'Hello World!',
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
