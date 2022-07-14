# RB-Airflow

## 환경셋팅

- AWS EC2에서 docker-compose를 사용한 Airflow 빠른 시작 : https://dev.to/awscommunity-asean/airflow-quick-start-with-docker-compose-on-aws-ec2-fj3#How-to-run
- docker로 airflow 시작하기 : https://airflow.apache.org/docs/apache-airflow/stable/start/docker.html
- airflow docker로 설치시, docker 환경변수 셋팅
  - [dockerfile, docker-compose.yaml]에는 default 변수값만 적어놓고, 배포환경별로 변경되는 환경변수는 배포환경별 .env파일로 만들어서 관리하기
  - 최초 작동전 "environment.env"에 [git-sync url, email] 등 환경변수값을 (필수)작성해야함.
  - ".env"는 docker default env파일명인데, 기본env파일은 의도치않은 변수값을 셋팅할 수 있으므로, docker 명령어 옵션인 "--env-file"을 사용하기
  * https://blog.leocat.kr/notes/2021/05/15/docker-use-env-file
  * https://docs.docker.com/compose/environment-variables/
    - https://docs.docker.com/compose/env-file/
- dag 스케줄링: https://airflow.apache.org/docs/apache-airflow/stable/dag-run.html, https://airflow.apache.org/docs/apache-airflow/1.10.1/scheduler.html
- docker compose git sync 관련:

  1. https://hub.docker.com/r/openweb/git-sync/
  2. https://github.com/kubernetes/git-sync
  3. https://coffeewhale.com/kubernetes/git-sync/2020/02/22/git-sync/

- airflow 변수 설정 using dag : https://stackoverflow.com/questions/68745582/airflow-set-variable

- airflow에 apt패키지등 시스템패키지(sshpass등)가 추가된 custom image빌드가 필요한경우: [Dockerfile 에 작성저장하여 설치(권장), 또는 Dockerfile에서 설치가 잘 안되는경우 airflow컨테이너에 직접 bash접속하여 명령어로 설치]
- airflow에 pip패키지등 파이썬기반패키지 추가가 필요한경우: [requirements.txt, 또는 .env의 _PIP_ADDITIONAL_REQUIREMENTS]에 작성하여 설치

## 실행방법

1. env파일 설정 후, `docker-compose --env-file ./[development].env config` 실행하여 env(파일)값이 docker-compose.yaml 에 정상설정 되었는지 확인하기
2. config env값 정상설정 완료시, `docker-compose --env-file ./[development].env up [-d]` 실행하여 docker 컨테이너 생성실행(백그라운드 실행시 -d)
3. ~~airflow container 모두 실행되면 새 터미널에서 `docker-compose exec -u root airflow-worker bash -c "apt update && apt install sshpass"` 를 통해 worker컨테이너에 sshpass 설치~~
4. Dag 중 'variable_setting' Unpause(스위치온)하고 수동으로 실행(회사 윈도우 서버 접속 sshpass variable 셋팅됨)

## 참고사항

- 특정 컨테이너 접속 `docker exec -u root -it <container-id> bash`
- dag파일을 수정했는데도 airflow에 update가 안되면 git-sync 살펴보아야 함
- ec2 키파일 분실했을 때 https://bactoria.github.io/2019/09/08/EC2-%ED%82%A4%ED%8E%98%EC%96%B4-%EB%B6%84%EC%8B%A4%ED%96%88%EC%9D%84-%EB%95%8C-%ED%95%B4%EA%B2%B0%EB%B2%95/
- github access token 발급 : 오른쪽 상단 프로필 선택 -> setting -> 왼쪽 메뉴 중 developer settings -> Personal access tokens -> Generate new Token(잃어버리지 말것)
- github access token url: `https://<user>:<token> @github.com/<repository>`
