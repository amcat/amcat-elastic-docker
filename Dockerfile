FROM elasticsearch:5.4.0

RUN elasticsearch-plugin install analysis-icu 

RUN curl -L https://github.com/amcat/hitcount/archive/5.4.0.tar.gz | tar -zxvf - -C /usr/share/elasticsearch/plugins/

WORKDIR /usr/share/elasticsearch/config/scripts
RUN wget -q https://raw.githubusercontent.com/amcat/amcat/master/config/elasticsearch/amcat_remove_from_set.groovy \
    && wget -q https://raw.githubusercontent.com/amcat/amcat/master/config/elasticsearch/amcat_add_to_set.groovy \
    && wget -q https://raw.githubusercontent.com/amcat/amcat/master/config/elasticsearch/amcat_lead.groovy

WORKDIR /usr/share/elasticsearch
