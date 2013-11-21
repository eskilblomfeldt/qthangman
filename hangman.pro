android: QT += androidextras

# Add more folders to ship with the application, here
folder_01.source = qml/hangman
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    data.cpp

android: SOURCES += data_android.cpp
else: SOURCES += data_default.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/hangman/Hangman.qml \
    enable1.txt \
    android-source/AndroidManifest.xml \
    android-source/src/org/qtproject/example/hangman/HangmanActivity.java \
    android-source/src/com/android/vending/billing/IInAppBillingService.aidl

HEADERS += \
    data.h

RESOURCES += \
    main.qrc

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-source
