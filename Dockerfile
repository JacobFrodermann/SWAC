# syntax=docker/dockerfile:1

# SWAC is a static NetBeans HTML5 client project: it has no build step.
# This packages the document root as a WAR so that Payara auto-deploys it
# below the context root /SWAC, which is the path that consumers such as
# SmartDataJobs and the SWAC components reference absolutely.
#
# Build:
#   docker build -t swac-war:local .
#
# The resulting image is only an artifact carrier containing
# /opt/wars/SWAC.war. The master Payara image (SmartDataDeployment/
# Dockerfile.payara) copies that WAR into /opt/payara/deployments.
FROM alpine:3.20 AS build

RUN apk add --no-cache zip

WORKDIR /src

# Static document root. Everything ends up at the WAR root (index.html plus
# the swac/ directory), so the context root stays /SWAC.
COPY index.html ./
COPY swac ./swac

# Minimal WEB-INF: welcome files, MIME types and the pinned context root.
COPY docker/WEB-INF ./WEB-INF

RUN zip -qr /SWAC.war .

FROM alpine:3.20 AS artifact

COPY --from=build /SWAC.war /opt/wars/SWAC.war
