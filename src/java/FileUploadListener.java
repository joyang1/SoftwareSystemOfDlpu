
import com.yt.utils.FileUploadProperties;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Properties;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Web application lifecycle listener.
 *
 * @author 挺
 */
public class FileUploadListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        InputStream inStream = getClass().getClassLoader().getResourceAsStream("upload.properties");
        Properties properties = new Properties();
        try {
            properties.load(inStream);
            //System.out.println(""+properties);
            for(Map.Entry<Object,Object> prop: properties.entrySet()){
                String propertyName = (String) prop.getKey();
                String propertyValue = (String) prop.getValue();
                FileUploadProperties.getInstance().addProperty(propertyName, propertyValue);
            }
        } catch (IOException ex) {

        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
