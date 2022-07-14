# 참고: https://velog.io/@langssi/airflow2.1-image-%ED%99%95%EC%9E%A5%ED%95%98%EA%B8%B0
# https://airflow.apache.org/docs/apache-airflow/stable/start/docker.html#using-custom-images
# https://airflow.apache.org/docs/docker-stack/build.html
FROM ${AIRFLOW_IMAGE_NAME:-apache/airflow:2.2.2}

# root user의 권한이 필요한 경우 root 유저로 전환해주어야 한다.
USER root
# sshpass 사용자 id와 pwd를 한 줄에 사용하는 자동화 쉘 스크립트.
RUN apt-get update && apt-get install sshpass

# PyPI dependency들은 airflow user library 내에 설치되므로 다시 사용자를 전환한다.
USER airflow
# --no-cache-dir 옵션은 이미지 크기를 줄일수 있으므로 권장한다.
# requirements에 필요한 패키지들을 설치한다.
RUN if [ -e "requirements.txt" ]; then pip install --no-cache-dir --user -r /requirements.txt; fi