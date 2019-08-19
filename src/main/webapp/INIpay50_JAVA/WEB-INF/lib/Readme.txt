#INIpayTX 결제모듈 패키지의 ExecureCrypto_v1.0_jdk14.jar 라이브러리 설치안내


0. ExecureCrypto_v1.0_jdk14.jar 라이브러리는 암복호화 라이브러리로 반드시 필요합니다.

1. 웹서버 또는 WAS가 기동될 때 참조하는 루트 라이브러리 디렉토리나 JDK 확장 라이브러리 디렉토리에 올려주세요.

   - $jdk_home/jre/lib/ext/
   - tomcat의 경우, $TOMCAT_HOME/shared/lib 
   - weblogic의 경우, $WEBLOGIC_JDK_HOME/jre/lib/ext
   - resin의 경우, $RESIN_HOME/lib/
   - JBoss의 경우, {JAVAHOME}/jre/lib/ext/ 등

가맹점 서버 환경에 맞춰 파일을 올려주세요. 
해당 라이브러리가 정상적으로 로드되지 않느다면, 결제가 진행되지 않는 상황이 발생될 수 있습니다. 
또한 그로 인한 손/피해는 이니시스에 있지 않습니다.