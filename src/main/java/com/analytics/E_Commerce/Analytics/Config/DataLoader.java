package com.analytics.E_Commerce.Analytics.Config;
import com.analytics.E_Commerce.Analytics.Service.ImportService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataLoader implements CommandLineRunner {

    private final ImportService importService;

    public DataLoader(ImportService importService) {
        this.importService = importService;
    }

    @Override
    public void run(String... args) throws Exception {
        importService.importOrdersFromJson();
        System.out.println("orders imported successfully into MySQL.");
    }
}
