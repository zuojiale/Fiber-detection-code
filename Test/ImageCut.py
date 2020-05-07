import os
from PIL import Image

def splitimage(img, rownum, colnum, dstpath):
    img = img
    w, h = img.size
    if rownum <= h and colnum <= w:
        print('Original image info: %sx%s, %s, %s' % (w, h, img.format, img.mode))
        print('开始处理图片切割, 请稍候...')

        num = 0
        rowheight = h // rownum
        colwidth = w // colnum
        for r in range(rownum):
            for c in range(colnum):
                box = (c * colwidth, r * rowheight, (c + 1) * colwidth, (r + 1) * rowheight)
                croop = img.crop(box)
                croop.save(os.path.join(dstpath, r.__str__() + '-'+ c.__str__() + '.jpg'))
                num = num + 1

        print('图片切割完毕，共生成 %s 张小图片。' % num)
    else:
        print('不合法的行列切割参数！')

def imagecut(img, rows, cols, save_path):
    dstpath = save_path
    if  os.path.exists(dstpath):
        row = rows
        col = cols
        if row > 0 and col > 0:
            splitimage(img, row, col, dstpath)
        else:
            print('无效的行列切割参数！')
    else:
        print('图片输出目录 %s 不存在！' % dstpath)
