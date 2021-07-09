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
mkdir -p $SAVE/$MODEL

# start training locally
python train.py ${DATASET} \
    --user-dir fairnr \
    --task single_object_rendering \
    --train-views "0..100" \
    --view-resolution $RES \
    --max-sentences 1 \
    --view-per-batch 2 \
    --pixel-per-view 1024 \
    --no-preload \
    --sampling-on-mask 1.0 --no-sampling-at-reader \
    --valid-view-resolution $RES \
    --valid-views "100..200" \
    --valid-view-per-batch 1 \
    --transparent-background "1.0,1.0,1.0" \
    --background-stop-gradient \
    --arch $ARCH \
    --initial-boundingbox ${DATASET}/bbox.txt \
    --raymarching-stepsize-ratio 0.125 \
    --use-octree \
    --discrete-regularization \
    --color-weight 128.0 \
    --alpha-weight 1.0 \
    --optimizer "adam" \
    --adam-betas "(0.9, 0.999)" \
    --lr-scheduler "polynomial_decay" \
    --total-num-update 150000 \
    --lr 0.001 \
    --clip-norm 0.0 \
    --criterion "srn_loss" \
    --num-workers 0 \
    --seed 2 \
    --save-interval-updates 500 --max-update 150000 \
    --virtual-epoch-steps 5000 --save-interval 1 \
    --half-voxel-size-at  "5000,25000,75000" \
    --reduce-step-size-at "5000,25000,75000" \
    --pruning-every-steps 2500 \
    --keep-interval-updates 5 \
    --log-format simple --log-interval 1 \
    --save-dir ${SAVE}/${MODEL} \
    --tensorboard-logdir ${SAVE}/tensorboard/${MODEL} \
     | tee -a $SAVE/train.log

