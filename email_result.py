import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.header import Header



# 邮箱发送
def Send_mail(text):
    msg_from = '2368955446@qq.com'  # 发送方邮箱
    passwd = 'bsxjutfhqkuqecgh'  # 填入发送方邮箱的授权码
    msg_to = '2368955446@qq.com'  # 收件人邮箱

    subject = "深度学习训练结果"  # 主题
    msg = MIMEText(text)
    msg['Subject'] = subject
    msg['From'] = msg_from
    msg['To'] = msg_to
    try:
        s = smtplib.SMTP_SSL("smtp.qq.com", 465)
        s.login(msg_from, passwd)
        s.sendmail(msg_from, msg_to, msg.as_string())
        print('succeed')
    except:
        print("发送失败")
    finally:
        s.quit()
