#include <QApplication>
#include <QPushButton>
#include <QLabel>
#include <QSpinBox>
#include <QSlider>
#include <QHBoxLayout>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QWidget *window = new QWidget;              // greate new widget
    window->setWindowTitle("Enter Your age:");  // set the title

    // set the spinbox and slider and range
    QSpinBox *spinbox = new QSpinBox;
    QSlider *slider = new QSlider(Qt::Horizontal);
    spinbox->setRange(0, 130);
    slider->setRange(0,130);

    // connet the value of spinbox and slider
    QObject::connect(spinbox, SIGNAL(valueChanged(int)), slider, SLOT(setValue(int)));
    QObject::connect(slider, SIGNAL(valueChanged(int)), spinbox, SLOT(setValue(int)));

    // set the default value of spinbox
    spinbox->setValue(35);

    // create a layout manager contained the widges and automatically set
    QHBoxLayout *layout = new QHBoxLayout;
    // the spinbox and slider are reparented to the layout
    layout->addWidget(spinbox);
    layout->addWidget(slider);

    // set layout
    window->setLayout(layout);
    window->show();

    return a.exec();
}

 
