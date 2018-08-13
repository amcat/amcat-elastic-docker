FROM docker.elastic.co/elasticsearch/elasticsearch:5.4.3

RUN bin/elasticsearch-plugin install analysis-icu \
    && bin/elasticsearch-plugin install https://github.com/amcat/hitcount/releases/download/5.4.3/hitcount-5.4.3-plugin.zip

RUN mkdir config/scripts \
    && wget -q https://raw.githubusercontent.com/amcat/amcat/master/config/elasticsearch/amcat_remove_from_set.groovy -O config/scripts/amcat_remove_from_set.groovy \
    && wget -q https://raw.githubusercontent.com/amcat/amcat/master/config/elasticsearch/amcat_add_to_set.groovy -O config/scripts/amcat_add_to_set.groovy \
    && wget -q https://raw.githubusercontent.com/amcat/amcat/master/config/elasticsearch/amcat_lead.groovy -O config/scripts/amcat_lead.groovy

ENV xpack.security.enabled=false

ADD elasticsearch.yml /usr/share/elasticsearch/config/
USER root
RUN chown elasticsearch:elasticsearch config/elasticsearch.yml
USER elasticsearch
