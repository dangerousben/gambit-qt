#include <string.h>

#include <QApplication>
#include <QPushButton>
#include <QWebView>

extern "C" const char *q_connect(QObject *source, const char *signal,
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

extern "C" QApplication *make_q_application()
{
	// FIXME: how do we get argc and argv?
	return new QApplication(0, 0);
}

extern "C" void q_application_exec(QApplication *app)
{
	app->exec();
}

extern "C" QPushButton *make_q_push_button(char *text)
{
	QString str = QString::fromUtf8(text);
	return new QPushButton(str);
}

extern "C" void q_widget_resize(QWidget *widget, int w, int h)
{
	widget->resize(w, h);
}

extern "C" void q_widget_show(QWidget *widget)
{
	widget->show();
}

extern "C" QWebView *make_q_web_view()
{
	return new QWebView();
}

extern "C" void q_web_view_load(QWebView *view, const char *u)
{
	QString str = QString::fromUtf8(u);
	QUrl url = QUrl(str);
	view->load(url);
}
