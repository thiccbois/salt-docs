FROM pierrezemb/gostatic

#
# docker run -d -p 80:8043 -v path/to/mkdocs/site:/srv/http --name salt-docs rosscdh/salt-docs
#
EXPOSE 8043

ARG BUILD_COMMIT_SHA1
ARG BUILD_COMMIT_DATE
ARG BUILD_BRANCH
ARG BUILD_DATE
ARG BUILD_REPO_ORIGIN

ENV BUILD_COMMIT_SHA1=$BUILD_COMMIT_SHA1
ENV BUILD_COMMIT_DATE=$BUILD_COMMIT_DATE
ENV BUILD_BRANCH=$BUILD_BRANCH
ENV BUILD_DATE=$BUILD_DATE
ENV BUILD_REPO_ORIGIN=$BUILD_REPO_ORIGIN

CMD ["-append-header", "X-Version:${BUILD_COMMIT_SHA1}", "-default-user-basic-auth", "salt-docs", "-enable-basic-auth", "-port", "8043", "-set-basic-auth", "salt-docs:salty2018"]