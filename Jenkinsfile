node{
   stage('SCM Checkout'){
     git 'https://github.com/bmoorthi/my-app.git'
   }
   stage('Compile-Package'){

      def mvnHome =  tool name: 'maven-3.8', type: 'maven'   
      sh "${mvnHome}/bin/mvn clean package"
	  sh 'mv target/myweb*.war target/newapp.war'
   }
   stage('Build Docker Imager'){
   sh 'docker build -t moorthy92/java-maven-app:jvm-1.3 .'
   }
   stage('Docker Image Push'){
   withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASS', usernameVariable: 'UESR')]) {
   sh "docker login -u moorthy92 -p ${PASS}"
    }
   sh 'docker push moorthy92/java-maven-app:jvm-1.3'
   }
   stage('Nexus Image Push'){
   sh "docker login -u admin -p admin123 54.242.99.239:9001"
   sh "docker tag moorthy92/java-maven-app:jvm-1.3 54.242.99.239:9001/damo:1.0.0"
   sh 'docker push 54.242.99.239:9001/damo:1.0.0'
   }
   stage('Remove Previous Container'){
	try{
		sh 'docker rm -f tomcattest'
	}catch(error){
		//  do nothing if there is an exception
	}
   stage('Docker deployment'){
   sh 'docker run -d -p 8090:8080 --name tomcattest moorthy92/java-maven-app:jvm-1.3' 
   }
}
}
