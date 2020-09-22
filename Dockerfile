FROM tensorflow/serving

# check for mandatory args
ARG MODEL_NAME
RUN test -n "$MODEL_NAME"

ARG LOCAL_MODEL_DIR
RUN test -n "$LOCAL_MODEL_DIR"

ARG MODEL_VERSION
RUN test -n "$MODEL_VERSION"

# create a servable folder
RUN mkdir -p models/$MODEL_NAME/$MODEL_VERSION

# copy local model folder into the image
COPY $LOCAL_MODEL_DIR models/$MODEL_NAME/$MODEL_VERSION

# set the model name
ENV MODEL_NAME $MODEL_NAME