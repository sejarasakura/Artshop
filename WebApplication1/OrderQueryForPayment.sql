SELECT Art.art_id as art_id, Art.[image] as [image],  
                Art.artist_id as artist_id, Art.date_done as date_done,  
                [User].first_name + ' ' + [User].last_name + ';' + CONVERT(varchar(20),[OrderDetails].product_quantity) +
                ';' as [description],  
                Art.price as price, [Art].quantity as quantity,  
                Art.[name] as [name]  
                FROM [Art], [OrderDetails], [User]  
                WHERE OrderDetails.order_id = 0 AND  
                Art.artist_id = [User].[user_id] AND  
                Art.art_id = OrderDetails.art_id