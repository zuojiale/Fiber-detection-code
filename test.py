import os
import torch as t
from utils.config import opt
from model import FasterRCNNVGG16
from trainer import FasterRCNNTrainer
from data.util import  read_image
from utils.vis_tool import vis_bbox
from utils import array_tool as at
from utils.vis_tool import visdom_bbox
import numpy as np
from Test import ImageCut
from PIL import Image
import pandas as pd

save_path = 'C:/Users/86188/Desktop/fiber/Test/cut_image'   #分区图片保存路径
test_img_path = 'imgs/0002.jpg'    #检测图片路径

def test(**kwargs):
    #opt._parse(kwargs)
    opt.env = 'test'
    opt.caffe_pretrain = True
    faster_rcnn = FasterRCNNVGG16()
    trainer = FasterRCNNTrainer(faster_rcnn).cuda()

    trainer.load('C:/Users/86188/Desktop/fiber/checkpoints/fasterrcnn_05031937_0.9089769879243565')
    print('成功加载神经网络')

    #1.载入待检测图片
    img2 = Image.open(test_img_path)
    img_end = read_image(test_img_path)
    img_end = t.from_numpy(img_end)[None]


    #2.分割图片
    ImageCut.imagecut(img2, 12, 15, save_path)
    os.remove('bboxes.txt')  #先移除之前的文件

    #3.循环检测
    for filename in os.listdir(save_path):  # listdir的参数是文件夹的路径
        #print(filename)  # 此时的filename是文件夹中文件的名称

        img = read_image(os.path.join(save_path, filename))
        img = t.from_numpy(img)[None]

        opt.caffe_pretrain = False  # this model was trained from caffe-pretrained model
        _bboxes, _labels, _scores = trainer.faster_rcnn.predict(img, visualize=True)
        bboxes = at.tonumpy(_bboxes[0])
        scores = at.tonumpy(_scores[0])
        labels = at.tonumpy(_labels[0])
        #print(bboxes)  #输出框的坐标，array格式
        #print(scores)

        #4.换算到绝对坐标
        fn = filename.split('-')
        row = fn[0]
        col1 = fn[1]
        col2 = col1.split('.')
        col = col2[0]
        print(row, col)
        #部分图识别结果显示
        part_img = visdom_bbox(at.tonumpy(img[0]),
                               bboxes,
                               labels.reshape(-1),
                               scores.reshape(-1)
                               )
        trainer.vis.img('part_img', part_img)

        #换算到绝对坐标
        bboxes[:, 0] = bboxes[:, 0] + int(row)*500.333333   # x坐标
        bboxes[:, 1] = bboxes[:, 1] + int(col)*528.000000   # y坐标
        bboxes[:, 2] = bboxes[:, 2] + int(row)*500.333333    # x坐标
        bboxes[:, 3] = bboxes[:, 3] + int(col)*528.000000   # y坐标


        #5.绝对坐标保存到文件
        with open('bboxes.txt', 'ab') as f:
            np.savetxt(f, bboxes, fmt="%f", delimiter=",")  # 保存为float
        print('绝对坐标保存成功')


    #6.读取绝对坐标文件，并显示检测效果
    all_bboxes = np.loadtxt(open('bboxes.txt', "rb"), delimiter=",")
    test_img = visdom_bbox(at.tonumpy(img_end[0]),
                      all_bboxes,
                      #labels.reshape(-1),
                      #scores.reshape(-1)
                           )
    trainer.vis.img('test_img', test_img)

if __name__ == '__main__':
    #import fire
    #fire.Fire()
    test()