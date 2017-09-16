/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package agenciabancaria.Models;

/**
 *
 * @author matheus
 */
public class Conta_Cliente {
    private int id_cliente;
    private String agencia_nome;
    private int id_conta;

    public Conta_Cliente() {
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getAgencia_nome() {
        return agencia_nome;
    }

    public void setAgencia_nome(String agencia_nome) {
        this.agencia_nome = agencia_nome;
    }

    public int getId_conta() {
        return id_conta;
    }

    public void setId_conta(int id_conta) {
        this.id_conta = id_conta;
    }
}
