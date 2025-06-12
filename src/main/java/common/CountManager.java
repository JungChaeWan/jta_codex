package common;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class CountManager implements HttpSessionListener {
    public static int count;

    public static int getCount() {
        return count;
    }

    public void sessionCreated(HttpSessionEvent event) {
        //세션이 만들어질 때 호출
        HttpSession session = event.getSession(); //request에서 얻는 session과 동일한 객체
        session.setMaxInactiveInterval(60*20);

        count++;

        session.getServletContext().log(session.getId() + " createdSession " + ", number of session : " + count);
    }

    public void sessionDestroyed(HttpSessionEvent event) {
        //세션이 소멸될 때 호출
        count--;
        if(count<0)
            count=0;

        HttpSession session = event.getSession();
        session.getServletContext().log(session.getId() + " destroyedSession " + ", number of session : " + count);
    }
}


