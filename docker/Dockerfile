# Specify fish version to use during build
# docker build -t <image> --build-arg FISH_VERSION=<version>
ARG FISH_VERSION
ARG SCREENSHOT_IMAGE=purefish/terminal-screenshot:fish-${FISH_VERSION}

FROM purefish/docker-fish:${FISH_VERSION} AS only-fish

# Redeclare ARG so its value is available after FROM (cf. https://github.com/moby/moby/issues/34129#issuecomment-417609075)
ARG FISH_VERSION
RUN printf "\nBuilding \e[38;5;27mFish-%s\e[m\n\n" ${FISH_VERSION}

# Install dependencies
USER root
# hadolint ignore=DL3018
RUN apk add \
    --no-cache \
    coreutils \
    bluez \
    networkmanager \
    sudo \
    shadow \
    vim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# hadolint ignore=DL3004
RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel \
    && usermod -g wheel nemo \
    && echo "nemo:123" | sudo chpasswd
USER nemo

# create an image with smart-lock's source code for testing (lightweight)
FROM only-fish AS with-smart-lock-installed 
USER root
RUN chmod -R 777 /home/nemo
WORKDIR /home/nemo/.config/fish/smart-lock.fish/
COPY --chown=nemo:nemo ./ /home/nemo/.config/fish/smart-lock.fish/
USER nemo

ENTRYPOINT ["fish", "-c"]
CMD ["fishtape tests/*.test.fish"]
