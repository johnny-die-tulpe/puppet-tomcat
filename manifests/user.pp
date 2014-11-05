class tomcat::user {
  if ! defined(User[$::tomcat::tomcat_user]) {
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
    }
 }
}
