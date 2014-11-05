# create only the user if its the default user
# else just homedirctory will be changed
class tomcat::user {
  if $::tomcat::tomcat_user == 'tomcat' {
    user { $::tomcat::tomcat_user :
      ensure => present,
      uid    => $::tomcat::tomcat_uid,
      gid    => $::tomcat::tomcat_gid,
      system => true,
      home   => $::tomcat::instance_basedir,
    }
  } else {
    exec{'modify tomcat user home':
      command => "/usr/sbin/usermod -m -d ${::tomcat::instance_basedir} ${::tomcat::tomcat_user}",
      unless  => "/bin/egrep '(${::tomcat::tomcat_user}.*:${::tomcat::instance_basedir}:)' /etc/passwd",
      require => User[$::tomcat::tomcat_user],
    }
  }
}
