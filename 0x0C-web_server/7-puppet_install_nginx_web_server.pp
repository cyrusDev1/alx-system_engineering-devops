# install nginx  (w/ Puppet)
package { 'nginx':
    ensure => installed,
}

file_line { 'Nginx default file':
    ensure => 'present',
    path   => '/etc/nginx/sites-available/default',
    after  => 'server_name _;',
    line   => "\n\tlocation /redirect_me {\n\t\treturn 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;\n\t}\n",
}

file { '/var/www/html/index.html':
    content => 'Hello World!',
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
