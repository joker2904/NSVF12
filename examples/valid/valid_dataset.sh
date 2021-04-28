# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

# just for debugging
DATA="Bike"
RES="200x200"
ARCH="nsvf_base"
SUFFIX="v1"
DATASET=/tmp/roy0/mountpoint/Dataset/${DATA}
SAVE=/tmp/roy0/mountpoint/savepoint/${DATA}
MODEL=$ARCH$SUFFIX
MODEL_PATH=${SAVE}/${MODEL}/checkpoint_last.pt

# start validating a trained model with target images.
# CUDA_VISIBLE_DEVICES=0 \
python validate.py ${DATASET} \
    --user-dir fairnr \
    --valid-views "200..400" \
    --valid-view-resolution $RES \
    --no-preload \
    --task single_object_rendering \
    --max-sentences 1 \
    --valid-view-per-batch 1 \
    --path ${MODEL_PATH} \
    --model-overrides '{"chunk_size":1024,"raymarching_tolerance":0.01,"tensorboard_logdir":"","eval_lpips":True}' \
