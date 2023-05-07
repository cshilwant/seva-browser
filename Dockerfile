FROM kalilinux/kali-rolling:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
	wget \
	fonts-noto \
	&& rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate https://ftp.mozilla.org/pub/firefox/releases/102.9.0esr/linux-x86_64/en-US/firefox-102.9.0esr.tar.bz2 && tar -xvf firefox-102.9.0esr.tar.bz2 \
COPY ./firefox /usr/lib/
    
RUN mkdir -p /root/.mozilla/firefox/default
COPY ./prefs.js /root/.mozilla/firefox/default/prefs.js
COPY ./enterprise_policy/* /usr/lib/firefox/

RUN useradd -m user
RUN mkdir -p /home/user/.mozilla/firefox/default
COPY ./prefs.js /home/user/.mozilla/firefox/default/prefs.js
RUN chown user:user -R /home/user

copy entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
