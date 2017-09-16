/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package agenciabancaria.Controllers;

import agenciabancaria.Models.Cliente;
import agenciabancaria.Models.Conta;
import agenciabancaria.Models.Conta_Cliente;
import agenciabancaria.Models.Corrente;
import agenciabancaria.Models.Operacao_Bancaria;
import agenciabancaria.Models.Emprestimo;
import agenciabancaria.Models.Emprestimo_Cliente;
import agenciabancaria.Models.Poupanca;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import static java.sql.Types.NULL;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author matheus
 */
public class DBConnection {
    
    public static Connection current = null;
    private DBConnection() {}
    
    private final static String HOST = "jdbc:postgresql://localhost/postgres?currentSchema=agencia_bancaria";
    private final static String USER = "postgres";
    private final static String PASS = "12345";
    
    public static synchronized Connection getConnection() throws SQLException {
        if (current == null) {
            current = DriverManager.getConnection(HOST, USER, PASS);
        }
        return current;
    }
    
    public static void close() throws SQLException {
        if (current != null)
            current.close();
    }
    
    public static int insere(Object ob, String extra) {
        String sql = "";
        int r = 1;
       
        try{
            if(ob.getClass() == Operacao_Bancaria.class){
                sql += "INSERT INTO operacao_bancaria VALUES (NEXTVAL('Seq_Operacao'), ? , ? , ? , ? , ? , ?);";
                Operacao_Bancaria op = (Operacao_Bancaria)ob;
                PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql);
                stmt.setInt(1, op.getId_conta());
                stmt.setString(2, op.getAgencia_nome());
                stmt.setString(3, op.getTipo());
                stmt.setFloat(4, op.getValor());
                stmt.setDate(5, new java.sql.Date(op.getAno()-1900, op.getMes()-1, op.getDia()));
                stmt.setString(6, op.getDescricao());
                r = stmt.executeUpdate();
            } 
            else if(ob.getClass() == Emprestimo.class){
                sql += "INSERT INTO emprestimo VALUES (NEXTVAL('Seq_Emprestimo'), ?, ?, ?);";
                Emprestimo emp = (Emprestimo)ob;
                PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql);
                stmt.setFloat(1, emp.getValor());
                stmt.setInt(2, emp.getQuantparcelas());
                stmt.setString(3, emp.getAgencia_nome());
                r = stmt.executeUpdate();
            }
            else if(ob.getClass() == Emprestimo_Cliente.class){
                sql += "INSERT INTO emprestimo_cliente VALUES (?, ?);";
                Emprestimo_Cliente empc = (Emprestimo_Cliente)ob;
                PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql);
                stmt.setInt(1, empc.getId_emprestimo());
                stmt.setInt(2, empc.getId_cliente());
                r = stmt.executeUpdate();
            }
            else if(ob.getClass() == Cliente.class){
                sql += "INSERT INTO cliente VALUES (NEXTVAL('Seq_Cliente'), ?, ? ,?, ?, ?, ?, ?);";
                Cliente cli = (Cliente)ob;
                PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql);
                stmt.setString(1, cli.getNome());
                stmt.setString(2, cli.getCpf());
                stmt.setDate(3, new java.sql.Date(cli.getAno()-1900, cli.getMes()-1, cli.getDia()));
                stmt.setString(4, cli.getEndereco());
                stmt.setString(5, cli.getCidade());
                stmt.setString(6, cli.getEstado());
                stmt.setInt(7, cli.getGerente() == -1 ? NULL : cli.getGerente());
                r = stmt.executeUpdate();
            }
            else if(ob.getClass() == Conta.class){
                sql += "INSERT INTO conta VALUES(NEXTVAL('Seq_Conta'), ?, ?, ?, ?, ?);";
                Conta con = (Conta)ob;
                PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql);
                System.out.println(con.getAno() + " " + con.getMes() + " " + con.getDia());
                stmt.setDate(1, new java.sql.Date(con.getAno()-1900, con.getMes()-1, con.getDia()));
                stmt.setFloat(2, 0);
                stmt.setDate(3, new java.sql.Date(con.getAno()-1900, con.getMes()-1, con.getDia()));
                stmt.setString(4, con.getAgencia_nome());
                stmt.setString(5, con.getTipo_conta());
                r = stmt.executeUpdate();
            }
            else if(ob.getClass() == Emprestimo_Cliente.class){
                sql += "INSERT INTO emprestimo_cliente(id_emprestimo, id_cliente) VALUES (?, ?);";
                Emprestimo_Cliente emc = (Emprestimo_Cliente)ob;
                PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql);
                stmt.setInt(1, emc.getId_emprestimo());
                stmt.setInt(2, emc.getId_cliente());
                r = stmt.executeUpdate();
            }
            else if(ob.getClass() == Conta_Cliente.class){
                sql += "INSERT INTO conta_cliente VALUES(? , ? , ?);";
                Conta_Cliente concli = (Conta_Cliente)ob;
                PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql);
                stmt.setInt(1, concli.getId_cliente());
                stmt.setString(2, concli.getAgencia_nome());
                stmt.setInt(3, concli.getId_conta());
                r = stmt.executeUpdate();
            }
            else if(ob.getClass() == Corrente.class){
                sql += "INSERT INTO corrente VALUES(? , ? , ?);";
                Corrente corr = (Corrente)ob;
                PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql);
                stmt.setString(1, corr.getAgencia_nome());
                stmt.setInt(2, corr.getId_conta());
                stmt.setFloat(3, corr.getTarifa_mensal());
                r = stmt.executeUpdate();
            }
            else if(ob.getClass() == Poupanca.class){
                sql += "INSERT INTO poupanca VALUES(? , ? , ?);";
                Poupanca pou = (Poupanca)ob;
                PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql);
                stmt.setString(1, pou.getAgencia_nome());
                stmt.setInt(2, pou.getId_conta());
                stmt.setFloat(3, pou.getTaxa_juros());
                r = stmt.executeUpdate();
            }
        } catch(Exception e){
            e.printStackTrace();
            return -1;
        }
        
        return r; 
    }
    
    public static ResultSet seleciona(String sql){
        
        ResultSet resposta;
        
        try{
            PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            resposta = stmt.executeQuery();
            return resposta;
            
        } catch(Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static int atualiza(String sql){
        try{
            
            PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql);
            return stmt.executeUpdate();
            
        } catch(Exception e){
            e.printStackTrace();
            return -1;
        }
    }
     
}
