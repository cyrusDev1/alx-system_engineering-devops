# kills a process
exec { 'killmenow':
    command => '/usr/bin/pkill killmenow',
    returns => [0, 1]
}