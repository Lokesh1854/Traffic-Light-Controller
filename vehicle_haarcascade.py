import cv2 as cv
import os

def check_vehicles(vehicles_rect):
    if (len(vehicles_rect) > 0):
        return 1
    else:
        return 0

# DIR = r'C:\Users\lokes\OneDrive\Desktop\verilog\verilog2.0\Projects\Traffic_Light_Controller\video.mp4'    # directory of video file

capture = cv.VideoCapture('video.mp4')              # camptures the video from directory

#   we are using haar_cascade to detect vehicle in frame
vehicle_haar_cascade = cv.CascadeClassifier('vehicles.xml')     

#   we read video frame be frame, by using a while loop

while True:

    #   capture.read() reads video frame by frame and returns frame,
    #   and a boolean which says whether the frame was successfully read or not

    isTrue, frame = capture.read()                      # will read frame by frame
    gray = cv.cvtColor(frame,cv.COLOR_BGR2GRAY)

    vehicles_rect = vehicle_haar_cascade.detectMultiScale(gray, scaleFactor = 1.15, minNeighbors = 4)   # haar_cascade to detect vehicle
    print(check_vehicles(vehicles_rect))

    for (x,y,w,h) in vehicles_rect:                     #   to mark detected vehicle
        cv.rectangle(frame,(x,y),(x+w,y+h),(0,255,0),thickness=2)
    frame_1 = frame [1 : 720 , 100 : frame.shape[1]-150]
    cv.imshow('frame',frame_1)

    if cv.waitKey(20)   & 0xFF == ord('d') :            #   to exit the while loop on pressing key 'd'
        break

capture.release()       #   after video reading process is done, we can release capture pointer
cv.destroyAllWindows()  #   destroys all windows