#include <string.h>

#include <QApplication>
#include <QPushButton>
#include <QWebView>

extern "C" const char *qt_connect(QObject *source, const char *signal,
				  QObject *dest, const char *slot)
{
	// FIXME: this is horrible and will probably break between qt versions
	//        not sure what else can be done though :(

	char *psignal, *pslot;

	psignal = (char *) malloc(strlen(signal) + 4);
	*psignal = '2';
	strcpy(psignal + 1, signal);
	strcat(psignal, "()");

	pslot = (char *) malloc(strlen(slot) + 4);
	*pslot = '1';
	strcpy(pslot + 1, slot);
	strcat(pslot, "()");

	QObject::connect(source, psignal, dest, pslot);

	free(psignal);
	free(pslot);
}

extern "C" QApplication *make_qapplication()
{
	// FIXME: how do we get argc and argv?
	int argc = 1;
	char *argv[] = {"hello"};

	return new QApplication(argc, argv);
}

extern "C" void qapplication_exec(QApplication *app)
{
	app->exec();
}

extern "C" QPushButton *make_qpushbutton(char *text)
{
	QString str = QString::fromUtf8(text);
	return new QPushButton(str);
}

extern "C" void qwidget_resize(QWidget *widget, int w, int h)
{
	widget->resize(w, h);
}

extern "C" void qwidget_show(QWidget *widget)
{
	widget->show();
}

extern "C" QWebView *make_qwebview()
{
	return new QWebView();
}

extern "C" void qwebview_load(QWebView *view, const char *u)
{
	QString str = QString::fromUtf8(u);
	QUrl url = QUrl(str);
	view->load(url);
}
