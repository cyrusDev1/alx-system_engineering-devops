# Time to practice configuring your server with Puppet! Just as you
# did before, we’d like you to install and configure an Nginx server
# using Puppet instead of Bash. To save time and effort, you should
# also include resources in your orm a 301 redirect when querying /redirect_me.

exec { 'updating packages':
    command => 'apt-get -y update',
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

package { 'nginx':
    ensure => installed,
}

file { '/var/www/html/index.html':
    content => 'Hello World!',
}

file_line { 'configure redirection':
    path  => '/etc/nginx/sites-available/default',
    after => 'server_name _;',
    line  => "\n\tlocation /redirect_me {\n\treturn 301 https://www.youtube.com/watch?v=QH2-TGUlwu4\n\t}",
}

service { 'nginx':
    ensure => running,
}
