#ifndef FINDDIALOG_H
#define FINDDIALOG_H

#include <QDialog>

// forward declaration
class QCheckBox;
class QLabel;
class QLineEdit;
class QPushButton;

// define FindDialog class
class FindDialog : public QDialog
{
    Q_OBJECT	// necessary if define signals or slots

public:
    FindDialog(QWidget *parent = 0);	// construction function

signals:	// define signals
    void findNext(const QString &str, Qt::CaseSensitivity cs);
    void findPrevious(const QString &str, Qt::CaseSensitivity cs);

private slots:	// define slots
    void findClicked();
    void enableFindButton(const QString &text);

private:	// widgets
    QLabel *label;
    QLineEdit *lineEdit;
    QCheckBox *caseCheckBox;
    QCheckBox *backwardCheckBox;
    QPushButton *findButton;
    QPushButton *closeButton;
};

#endif
