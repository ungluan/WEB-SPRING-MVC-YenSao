package ptithcm.controller.user;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ptithcm.bean.UploadFile;

@Controller
@RequestMapping("image/")
public class ImageController {
	@Autowired
	ServletContext context;
	
	/*
	 * @Autowired
	 * 
	 * @Qualifier("uploadfile") UploadFile baseUploadFile;
	 */
	
	@RequestMapping("form")
	public String form() {
		return "user/form";
	}
	
	@RequestMapping("apply")
	public String apply( ModelMap model, @RequestParam("photo") MultipartFile photo ) throws IllegalStateException, IOException, InterruptedException {
		
		if(photo.isEmpty()) {
			model.addAttribute("message", "Vui lòng chọn file");
		}
		else {
			String photoPath = context.getRealPath("/resrouces/images/"+photo.getOriginalFilename());
			photo.transferTo(new File(photoPath));
			model.addAttribute("photo_name",photo.getOriginalFilename());
			
			Thread.sleep(2500);
		}
		
		return "user/apply";
	}
}
